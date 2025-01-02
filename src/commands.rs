use tauri::{AppHandle, command, Runtime};

use crate::models::*;
use crate::Result;
use crate::FsIosExt;

#[command]
pub(crate) async fn ping<R: Runtime>(
    app: AppHandle<R>,
    payload: PingRequest,
) -> Result<PingResponse> {
    app.fs_ios().ping(payload)
}

#[command]
pub(crate) async fn create_file<R: Runtime>(
    app: AppHandle<R>,
    payload: FSRequest,
) -> Result<FSResponse> {
    app.fs_ios().create_file(payload)
}

#[command]
pub(crate) async fn read_file<R: Runtime>(
    app: AppHandle<R>,
    payload: FSRequest,
) -> Result<FSResponse> {
    app.fs_ios().read_file(payload)
}

#[command]
pub(crate) async fn write_file<R: Runtime>(
    app: AppHandle<R>,
    payload: FSRequest,
) -> Result<FSResponse> {
    app.fs_ios().write_file(payload)
}

#[command]
pub(crate) async fn append_to_file<R: Runtime>(
    app: AppHandle<R>,
    payload: FSRequest,
) -> Result<FSResponse> {
    app.fs_ios().append_to_file(payload)
}

#[command]
pub(crate) async fn delete_file<R: Runtime>(
    app: AppHandle<R>,
    payload: FSRequest,
) -> Result<FSResponse> {
    app.fs_ios().delete_file(payload)
}

#[command]
pub(crate) async fn create_dir<R: Runtime>(
    app: AppHandle<R>,
    payload: FSRequest,
) -> Result<FSResponse> {
    app.fs_ios().create_dir(payload)
}

#[command]
pub(crate) async fn list_dir<R: Runtime>(
    app: AppHandle<R>,
    payload: FSRequest,
) -> Result<FSResponse> {
    app.fs_ios().list_dir(payload)
}

#[command]
pub(crate) async fn current_dir<R: Runtime>(
    app: AppHandle<R>,
    payload: FSRequest,
) -> Result<FSResponse> {
    app.fs_ios().current_dir(payload)
}

#[command]
pub(crate) async fn delete_dir<R: Runtime>(
    app: AppHandle<R>,
    payload: FSRequest,
) -> Result<FSResponse> {
    app.fs_ios().delete_dir(payload)
}

#[command]
pub(crate) async fn rename_dir<R: Runtime>(
    app: AppHandle<R>,
    payload: RenameRequest,
) -> Result<FSResponse> {
    app.fs_ios().rename_dir(payload)
}
