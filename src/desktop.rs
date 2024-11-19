use std::{fmt::Debug, io::ErrorKind};

use serde::de::DeserializeOwned;
use tauri::{plugin::PluginApi, AppHandle, Runtime};

use crate::{error, models::*};

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
  
  pub fn read_file(&self, payload: FSRequest) -> crate::Result<FSResponse> {
    Ok(FSResponse {
      value: Some("success".to_string()),
    })
  }
  
  pub fn delete_file(&self, payload: FSRequest) -> crate::Result<FSResponse> {
    Err(error::Error::Io(std::io::Error::new(ErrorKind::Unsupported, "Unsupported Operation")))
  }
  
  pub fn create_dir(&self, payload: FSRequest) -> crate::Result<FSResponse> {
    Err(error::Error::Io(std::io::Error::new(ErrorKind::Unsupported, "Unsupported Operation")))
  }
  
  pub fn list_dir(&self, payload: FSRequest) -> crate::Result<FSResponse> {
    Err(error::Error::Io(std::io::Error::new(ErrorKind::Unsupported, "Unsupported Operation")))
  }
  
  pub fn delete_dir(&self, payload: FSRequest) -> crate::Result<FSResponse> {
    Err(error::Error::Io(std::io::Error::new(ErrorKind::Unsupported, "Unsupported Operation")))
  }
  
  pub fn rename_dir(&self, payload: RenameRequest) -> crate::Result<FSResponse> {
    Err(error::Error::Io(std::io::Error::new(ErrorKind::Unsupported, "Unsupported Operation")))
  }
}
