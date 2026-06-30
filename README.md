# study_planner

A Flutter study planner app with Firebase integration for Firestore and Cloud Storage.

## Firebase Overview

This project uses Firebase for data persistence and file storage.
The main Firebase packages are:

- `firebase_core` — initializes Firebase.
- `cloud_firestore` — reads and writes structured app data.
- `firebase_storage` — uploads note images and retrieves download URLs.

## Firebase Initialization

### `lib/main.dart`

The app initializes Firebase before calling `runApp()`:

- `WidgetsFlutterBinding.ensureInitialized()`
  - Required if platform APIs or async initialization run before the app starts.
- `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`
  - Boots the Firebase SDK with platform-specific settings from `lib/firebase_options.dart`.

This setup is essential for all Firebase calls to work later in the app.

## Firestore Data Structure

The app uses these Firestore collections:

- `course` — top-level collection for course documents.
- `course/{courseId}/assignment` — subcollection for assignments in each course.
- `course/{courseId}/note` — subcollection for notes in each course.
- `notifications` — top-level collection storing generated notification documents.

## Note Services

### `lib/services/database/note_services.dart`

This service manages notes using Firestore and Firebase Storage.

#### `createNote(String courseId, Note note)`

- If `note.imageData` exists, uploads the file with `StorageServices().uploadImage(...)`.
- Builds a `Note` object with the returned storage `imageUrl`.
- Saves the note to Firestore under:
  - `course/{courseId}/note`
- Uses `noteCollection.add(data)` to create a new document.
- Updates the document with `docRef.update({'id': docRef.id})` so the stored note includes its Firestore ID.

This method demonstrates:

- `CollectionReference` and `DocumentReference`
- `add()` to insert a new document
- `update()` to store the generated document ID
- error handling around upload and Firestore writes

#### `getNotes(String courseId)`

- Returns a `Stream<List<Note>>`.
- Reads real-time updates by calling `noteCollection.snapshots()`.
- Maps each `QueryDocumentSnapshot` to `Note.fromJson(...)`.

This is the core pattern for live Firestore UI updates.

#### `getNotesFromCourseName()`

- Fetches all course documents with `courseCollection.get()`.
- For each course, calls `getNotes(courseId).first` to load notes once.
- Returns a map keyed by course name.

This method is useful when the app needs grouped note lists by course.

## Assignment Services

### `lib/services/database/assignment_sevices.dart`

This service manages assignments in Firestore.

#### `createAssignment(String courseId, AssignmentModel assignment)`

- Converts `AssignmentModel` to JSON via `assignment.toJson()`.
- Writes to Firestore under `course/{courseId}/assignment` with `add()`.
- Updates the document with its generated ID using `docRef.update({'id': docRef.id})`.

#### `getAssignments(String courseId)`

- Returns a `Stream<List<AssignmentModel>>`.
- Uses `assignmentCollection.snapshots()` for real-time updates.
- Converts each doc with `AssignmentModel.fromJson(doc.data() as Map<String, dynamic>, doc.id)`.

#### `getAssignmentsFromCourseName()`

- Reads all courses from `course`.
- Loads assignments for each course by calling `getAssignments(id).first`.
- Returns a map from course name to assignment list.

This service shows the same Firestore patterns as notes, but focused on assignments.

## Notification Services

### `lib/services/database/notification_services.dart`

Notifications are stored in a top-level `notifications` collection.

#### `storeOvrueAssigenmnets()`

- Calls `AssignmentSevices().getAssignmentsFromCourseName()` to load overdue assignments.
- For each overdue assignment, checks if a notification document already exists with `notifications.doc(assignmentId).get()`.
- If it does not exist, creates the notification using `notificationDoc.set(notificationData.toJson())`.

This method illustrates:

- reading Firestore documents with `get()`
- writing with `set()`
- using document IDs to prevent duplicates
- generating app notifications from data logic

#### `getNotifications()`

- Reads all notification documents once with `notifications.get()`.
- Converts each document into `NotificationModel.fromJson(...)`.

If you want real-time notification updates, replace `.get()` with `.snapshots()`.

## Storage Services

### `lib/services/cloud_storage/storage.dart`

This service handles image uploads and URL validation.

#### `uploadImage({required noteImage, required courseId})`

- Uses `FirebaseStorage.instance` to get the storage singleton.
- Creates a storage path:
  - `note-images/{courseId}/{timestamp}.jpg`
- Uploads the file using `ref.putFile(noteImage, SettableMetadata(contentType: 'image/jpeg'))`.
- Waits for the upload to finish and then calls `snapShot.ref.getDownloadURL()`.
- Returns the public download URL that is stored in Firestore.

This method demonstrates how to:

- upload files to Firebase Storage
- use `Reference` objects
- read upload task state and retrieve a download URL

#### `imageExists(String imageUrl)`

- Converts a Storage URL to a `Reference` using `refFromURL(imageUrl)`.
- Calls `ref.getMetadata()` to verify the file still exists.
- Returns `true` if metadata can be read, otherwise `false`.

## Model Serialization

### `lib/models/assignment_model.dart`

- `toJson()` converts Dart fields to a Firestore-ready map.
- The `date` field is converted to `Timestamp.fromDate(date)`.
- `fromJson(...)` converts Firestore data back into a Dart model.
- It safely handles `Timestamp`, `DateTime`, and string date values.

### `lib/models/Notification_model.dart`

- `toJson()` also converts `dueDate` to `Timestamp.fromDate(dueDate)`.
- `fromJson(...)` converts `Timestamp` back to `DateTime`.

### `lib/models/note_model.dart`

- `toJson()` maps note fields to Firestore fields.
- `fromJson(...)` reads stored values into a Dart `Note`.

## Key Firebase Concepts Used

- `Firebase.initializeApp(...)` — required once at app startup.
- `FirebaseFirestore.instance` — entry point for Firestore operations.
- `CollectionReference` — represents a Firestore collection.
- `DocumentReference` — represents a Firestore document.
- `QuerySnapshot` / `QueryDocumentSnapshot` — results from Firestore reads.
- `snapshots()` — listens to real-time updates.
- `get()` — reads data once.
- `add()` — creates a new document with auto-generated ID.
- `set()` / `update()` — writes or updates document fields.
- `FirebaseStorage.instance` — entry point for Cloud Storage.
- `Reference` / `putFile()` — upload files.
- `getDownloadURL()` — retrieve a file access URL.

## Study Tips

- Focus on the service classes first: `note_services.dart`, `assignment_sevices.dart`, and `notification_services.dart`.
- Compare `snapshots()` and `get()` to understand real-time vs one-time reads.
- Notice how models use `toJson()` and `fromJson()` to bridge Dart objects and Firestore documents.
- Observe the storage flow: upload image → get URL → save URL in Firestore.

---

This README section is intended as a learning resource for the Firebase patterns used in this project.