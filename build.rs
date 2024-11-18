const COMMANDS: &[&str] = &["ping", "create_file", "read_file", "delete_file"];

fn main() {
  tauri_plugin::Builder::new(COMMANDS)
    .android_path("android")
    .ios_path("ios")
    .build();
}
