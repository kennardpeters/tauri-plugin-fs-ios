use serde::de::DeserializeOwned;
use tauri::{plugin::PluginApi, AppHandle, Runtime};

use crate::models::*;

pub fn init<R: Runtime, C: DeserializeOwned>(
  app: &AppHandle<R>,
  _api: PluginApi<R, C>,
) -> crate::Result<FsIos<R>> {
  Ok(FsIos(app.clone()))
}

/// Access to the fs-ios APIs.
pub struct FsIos<R: Runtime>(AppHandle<R>);

impl<R: Runtime> FsIos<R> {
  pub fn ping(&self, payload: PingRequest) -> crate::Result<PingResponse> {
    Ok(PingResponse {
      value: payload.value,
    })
  }
  
  pub fn create_file(&self, payload: FSRequest) -> crate::Result<FSResponse> {
    Ok(FSResponse {
      value: Some("success".to_string()),
    })
  }
}
