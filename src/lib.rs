use tauri::{
  plugin::{Builder, TauriPlugin},
  Manager, Runtime,
};

pub use models::*;

#[cfg(desktop)]
mod desktop;
#[cfg(mobile)]
mod mobile;

mod commands;
mod error;
mod models;

pub use error::{Error, Result};

#[cfg(desktop)]
use desktop::FsIos;
#[cfg(mobile)]
use mobile::FsIos;

/// Extensions to [`tauri::App`], [`tauri::AppHandle`] and [`tauri::Window`] to access the fs-ios APIs.
pub trait FsIosExt<R: Runtime> {
  fn fs_ios(&self) -> &FsIos<R>;
}

impl<R: Runtime, T: Manager<R>> crate::FsIosExt<R> for T {
  fn fs_ios(&self) -> &FsIos<R> {
    self.state::<FsIos<R>>().inner()
  }
}

/// Initializes the plugin.
pub fn init<R: Runtime>() -> TauriPlugin<R> {
  Builder::new("fs-ios")
    .invoke_handler(tauri::generate_handler![commands::ping, commands::create_file, commands::read_file, commands::delete_file, commands::create_dir, commands::list_dir, commands::delete_dir])
    //.invoke_handler(tauri::generate_handler![commands::create_file])
    .setup(|app, api| {
      #[cfg(mobile)]
      let fs_ios = mobile::init(app, api)?;
      #[cfg(desktop)]
      let fs_ios = desktop::init(app, api)?;
      app.manage(fs_ios);
      Ok(())
    })
    .build()
}
