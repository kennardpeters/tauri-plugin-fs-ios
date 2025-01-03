const COMMANDS: &[&str] = &["ping", "create_file", "read_file", "write_file", "append_to_file", "delete_file", "create_dir", "list_dir", "delete_dir", "rename_dir", "current_dir"];

fn main() {
  tauri_plugin::Builder::new(COMMANDS)
    .android_path("android")
    .ios_path("ios")
    .build();
}
