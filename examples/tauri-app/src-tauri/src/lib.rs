use tauri_plugin_fs_ios::*;

/* TODO: implement rust api for plugin
#[tauri::command]
#[cfg(mobile)]
fn greet(name: &str) -> String {
    let pingRequest = PingRequest{
        value: Some(name.to_string()),
    };
    let pingResponse = match ping(pingRequest) {
        Ok(v) => v,
        Err(e) => {
            panic!("{}", e);
        }
    };

    pingResponse.value.unwrap()
}
*/

//#[tauri::command]
//fn test_create_file(name: &str) -> String {
//    //create_file();
//}

//#[tauri::command]
//fn test_read_file(name: &str) -> String {
//    //read_dir();
//}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![greet /*, test_create_file, test_read_file*/])
        .plugin(tauri_plugin_fs_ios::init())
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
