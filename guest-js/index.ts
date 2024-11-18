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
  console.log("path");
  console.log("contents");
  return await invoke<{ value?: string }>("plugin:fs-ios|create_file", {
    payload: {
      path,
      contents,
    },
  }).then((r) => (r.value ? r.value : null));
}
