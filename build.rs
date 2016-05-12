use std::process::Command;

fn main() {
let output = Command::new("util/choose_postgresql_version").output().unwrap_or_else(|e| {
        panic!("Failed to execute process: {}", e)
    });
}
