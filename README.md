# Tauri Plugin fs-ios


## Introduction

This is a temporarily workaround for interacting with the filesystem on iOS using [tauri](https://tauri.app). It only allows access to the application's Documents directory under the app's bundle name.

## Installation

1. Install the npm package on the front-end

```sh
npm install tauri-plugin-fs-ios-api
```

2. Install the cargo crate on in the `src-tauri/`  crate

```sh
cargo install tauri-plugin-fs-ios 
```

3. Add init logic to `lib.rs` file 

```rust

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_fs_ios::init())
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
```

## Usage

### Create a file

```ts
import { createFile } from 'tauri-plugin-fs-ios-api'

const test_create_file = async(path: string, contents: string) => {

	return await createFile(path, contents)
}
```

### Read a file

```ts
import { readFile } from 'tauri-plugin-fs-ios-api'

const test_read_file = async(path: string) => {

    return await readFile(path, "");
}
```

### Write a file

```ts
import { writeFile } from 'tauri-plugin-fs-ios-api'

const test_write_file = async(path: string, contents: string) => {

	// overwrites previous contents of file
    return await writeFile(path, contents);
}
```
### Append to a file

```ts
import { appendToFile } from 'tauri-plugin-fs-ios-api'

const test_appending_to_file = async(path: string, contents: string) => {

	// appends to previous contents of file
    return await appendToFile(path, contents);
}
```

### Delete a file

```ts
import { deleteFile } from 'tauri-plugin-fs-ios-api'

const test_delete_file = async(path: string) => {

    return await deleteFile(path, "");
}
```
### Create a Directory

```ts
import { createDir } from 'tauri-plugin-fs-ios-api'

const test_create_directory = async(path: string) => {

    return await deleteFile(path, "");
}
```
### List Contents of Current Directory

```ts
import { listDir } from 'tauri-plugin-fs-ios-api'

const test_list_directory = async() => {

	// lists files and folders in current directory
    return await listDir("", "");
}
```
### Print current Path

```ts
import { currentDir } from 'tauri-plugin-fs-ios-api'

const test_printing_directory = async() => {

	// returns current path
    return await currentDir("", "");
}
```
### Delete a directory

```ts
import { deleteDir } from 'tauri-plugin-fs-ios-api'

const test_deleting_directory = async(path: string) => {

    return await deleteDir(path, "");
}
```
### Rename a directory

```ts
import { renameDir } from 'tauri-plugin-fs-ios-api'

const test_renaming_directory = async(oldDir: string, newDir: string) => {

    return await renameDir(oldDir, newDir);
}
```
