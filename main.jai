WORKSPACE_NAME :: "war1";
EXECUTABLE_NAME :: "war1.exe";

#if OS == .WINDOWS {
    OUTPUT_FOLDER_PATH :: "build/win64/";
} else if OS == .LINUX {
    OUTPUT_FOLDER_PATH :: "build/linux64/";
}

MODULES_PATH :: "jai-modules";
BUILD_FILE_PATH :: "src/war1.jai";

#if OS == .WINDOWS {
    LIBS_FOLDER_PATH :: "libs/win64/";
} else if OS == .LINUX {
    LIBS_FOLDER_PATH :: "libs/linux64/";
}

build :: () {
    set_working_directory(#filepath);

    // Don't produce output for this default workspace
    opts := getBuildOptions();
    opts.output_type = BuildOutputType.NO_OUTPUT;
    setBuildOptions(opts);

    opts.output_type = BuildOutputType.EXECUTABLE;
    opts.output_executable_name = EXECUTABLE_NAME;
    opts.output_path = OUTPUT_FOLDER_PATH;
    opts.shorten_filenames_in_error_messages = false;
    opts.backend = Compiler.Backend.LLVM;
    array_add(*opts.modules_search_path_array, MODULES_PATH);

    makeDirectoryIfNotExist(opts.output_path);

    // Start a new workspace for the actual program
    workspace := createWorkspace(WORKSPACE_NAME);
    setBuildOptions(opts, workspace);
    addBuildFile(BUILD_FILE_PATH, workspace);

    copyFiles(LIBS_FOLDER_PATH, opts.output_path);
}

copyFiles :: (source: string, dest: string) {
    visitor :: (info: *FileVisitInfo, paths: [2] string) {
        relativePath := info.full_name;
        advance(*relativePath, paths[0].count);
        outPath := concatenate(paths[1], "/", relativePath);
        makeDirectoryTree(getDirectoryPath(outPath));
        copyFile(info.full_name, outPath);
    }

    paths: [2] string;
    paths[0] = source;
    paths[1] = dest;

    res := visitFiles(paths[0], true, paths, visitor);
    assert(res);
}

makeDirectoryTree :: (directoryPath: string) {
    path := directoryPath;
    if (path.count > 0 && path[path.count - 1] == #char "/") {
        path.count -= 1;
    }

    if (path == "") {
        return;
    }

    parent := getDirectoryPath(path);
    makeDirectoryTree(parent);
    makeDirectoryIfNotExist(path);
}

#run build();

#scope_file

Compiler :: #import "Compiler";
getBuildOptions :: Compiler.get_build_options;
setBuildOptions :: Compiler.set_build_options;
createWorkspace :: Compiler.compiler_create_workspace;
addBuildFile :: Compiler.add_build_file;
BuildOutputType :: Compiler.Build_Output_Type;

File :: #import "File";
makeDirectoryIfNotExist :: File.make_directory_if_it_does_not_exist;

FileUtilities :: #import "File_Utilities";
FileVisitInfo :: FileUtilities.File_Visit_Info;
copyFile :: FileUtilities.copy_file;
visitFiles :: FileUtilities.visit_files;

#import "Basic";

String :: #import "String";
getDirectoryPath :: String.path_strip_filename;
concatenate :: String.concatenate;
