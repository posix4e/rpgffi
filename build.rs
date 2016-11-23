use std::process::Command;
use std::env;
use std::fs;
use std::os::unix::fs::symlink;

fn main() {

// allow configuration via env var. Set to the version number itself, like "9.5.3".
let env_var = env::var("RPGFFI_PG_VERSION");
let pg_vers = if env_var.is_ok() {
    env_var.unwrap()
} else {
    let cmd_vers = Command::new("pg_config").arg("--version").output().unwrap_or_else(|e| {
            panic!("Failed to execute pg_config: {}", e)
        });

    if !cmd_vers.status.success() {
        panic!("pg_config failed with {}", cmd_vers.status.code().unwrap());
    }

    // transform "PostgreSQL 9.6.1" to "9.6.1"
    String::from_utf8(cmd_vers.stdout).unwrap().chars()
        .skip_while(|c| *c != ' ')
        .skip(1)
        .collect::<String>()
};

// transform "9.6.1" to "96"
let short_vers = pg_vers.chars()
        .filter(|c| *c != '.')
        .take(2)
        .collect::<String>();

match fs::remove_file("src/lib.rs") {
    Ok(_) => (),
    Err(e) => panic!("couldn't remove lib.rs: {}", e)
}

let dest_filename = format!("pg{}.rs", short_vers);

if let Err(_) = fs::File::open(format!("src/{}", dest_filename)) {
    panic!("Destination file src/{} does not exist", dest_filename);
}

if let Err(e) = symlink(dest_filename, "src/lib.rs") {
    panic!("Symlink failed: {}", e);
}

}
