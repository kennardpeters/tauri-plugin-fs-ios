use serde::de::DeserializeOwned;
use tauri::{
  plugin::{PluginApi, PluginHandle},
  AppHandle, Runtime,
};

use crate::models::*;

#[cfg(target_os = "ios")]
tauri::ios_plugin_binding!(init_plugin_fs_ios);

// initializes the Kotlin or Swift plugin classes
pub fn init<R: Runtime, C: DeserializeOwned>(
  _app: &AppHandle<R>,
  api: PluginApi<R, C>,
) -> crate::Result<FsIos<R>> {
  #[cfg(target_os = "android")]
  let handle = api.register_android_plugin("", "FSPlugin")?;
  #[cfg(target_os = "ios")]
  let handle = api.register_ios_plugin(init_plugin_fs_ios)?;
  Ok(FsIos(handle))
}

/// Access to the fs-ios APIs.
pub struct FsIos<R: Runtime>(PluginHandle<R>);

impl<R: Runtime> FsIos<R> {
  pub fn ping(&self, payload: PingRequest) -> crate::Result<PingResponse> {
    self
      .0
      .run_mobile_plugin("ping", payload)
      .map_err(Into::into)
  }
  pub fn create_file(&self, payload: FSRequest) -> crate::Result<FSResponse> {
    println!("create_file mobile.rs: {:?}", payload);
    self
      .0
      .run_mobile_plugin("createFile", payload)
      .map_err(Into::into)
  }
}
