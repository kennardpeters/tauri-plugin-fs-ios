<script>
  import { ping, createFile, readFile, writeFile, appendToFile, deleteFile, createDir, listDir, currentDir, deleteDir, renameDir } from 'tauri-plugin-fs-ios-api'

	let response = ''

	function updateResponse(returnValue) {
		response += `[${new Date().toLocaleTimeString()}] ` + (typeof returnValue === 'string' ? returnValue : JSON.stringify(returnValue)) + '<br>'
	}

	function _ping() {
		ping("Pong!").then(updateResponse).catch(updateResponse)
	}
	
	function _createFile() {
		createFile("test_markdown.md", "contents of file!").then(updateResponse).catch(updateResponse)
	}
	
	function _readFile() {
		readFile("test_markdown.md", "").then(updateResponse).catch(updateResponse)
	}
	
	function _writeFile() {
		writeFile("test_markdown.md", "updated contents of file!").then(updateResponse).catch(updateResponse)
	}
	
	function _appendToFile() {
		appendToFile("test_markdown.md", "appended contents of file!").then(updateResponse).catch(updateResponse)
	}
	
	function _deleteFile() {
		deleteFile("test_markdown.md", "").then(updateResponse).catch(updateResponse)
	}
	
	function _createDir() {
		createDir("markdown", "").then(updateResponse).catch(updateResponse)
	}
	
	function _listDir() {
		listDir("", "").then(updateResponse).catch(updateResponse)
	}
	
	function _deleteDir() {
		deleteDir("markdown", "").then(updateResponse).catch(updateResponse)
	}
	
	function _renameDir() {
		renameDir("markdown", "markdown2").then(updateResponse).catch(updateResponse)
	}
	
	function _currentDir() {
		currentDir("", "").then(updateResponse).catch(updateResponse)
	}

</script>

<main class="container">

  <div>
    <div class="row">
      <button on:click="{_ping}">Ping</button>
    </div>
    
    <br />

    <div class="row">
      <button on:click="{_createFile}">Create file</button>
      <button on:click="{_readFile}">Read file</button>
    </div>
      
    <div class="row">
      <button on:click="{_writeFile}">Write file</button>
      <button on:click="{_appendToFile}">Append to file</button>
      <button on:click="{_deleteFile}">Delete file</button>
    </div>

    <br />

    <div>
      <button on:click="{_createDir}">Create Directory</button>
      <button on:click="{_listDir}">List Directory</button>
      <button on:click="{_deleteDir}">Delete Directory</button>
      <button on:click="{_renameDir}">Rename Directory</button>
      <button on:click="{_currentDir}">Current Directory</button>
    </div>

    <div>{@html response}</div>
  </div>

</main>

<style>
  .logo.vite:hover {
    filter: drop-shadow(0 0 2em #747bff);
  }

  .logo.svelte:hover {
    filter: drop-shadow(0 0 2em #ff3e00);
  }
</style>
