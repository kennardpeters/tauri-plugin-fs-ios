import { invoke } from "@tauri-apps/api/core";

export async function ping(value: string): Promise<string | null> {
  return await invoke<{ value?: string }>("plugin:fs-ios|ping", {
    payload: {
      value,
    },
  }).then((r) => (r.value ? r.value : null));
}

export async function createFile(
  path: string,
  contents: string,
): Promise<string | null> {
  return await invoke<{ value?: string }>("plugin:fs-ios|create_file", {
    payload: {
      path,
      contents,
    },
  }).then((r) => (r.value ? r.value : null));
}

export async function readFile(
  path: string,
  contents: string,
): Promise<string | null> {
  return await invoke<{ value?: string }>("plugin:fs-ios|read_file", {
    payload: {
      path,
      contents,
    },
  }).then((r) => (r.value ? r.value : null));
}

export async function deleteFile(
  path: string,
  contents: string,
): Promise<string | null> {
  return await invoke<{ value?: string }>("plugin:fs-ios|delete_file", {
    payload: {
      path,
      contents,
    },
  }).then((r) => (r.value ? r.value : null));
}

export async function createDir(
  path: string,
  contents: string,
): Promise<string | null> {
  return await invoke<{ value?: string }>("plugin:fs-ios|create_dir", {
    payload: {
      path,
      contents,
    },
  }).then((r) => (r.value ? r.value : null));
}
