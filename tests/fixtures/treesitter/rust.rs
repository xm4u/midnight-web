use std::fmt::Display;

const MAX_RETRIES: u8 = 4;

#[derive(Clone, Debug)]
enum State {
    Ready,
    Busy { task: String },
    Failed(String),
}

trait Repository<T> {
    fn find(&self, key: &str) -> Result<T, String>;
}

struct LocalStore;

impl Repository<String> for LocalStore {
    fn find(&self, key: &str) -> Result<String, String> {
        if key.is_empty() {
            Err("empty key".into())
        } else {
            Ok("sage".into())
        }
    }
}

struct Entry<'a, T> {
    name: &'a str,
    value: T,
    state: State,
}

impl<'a, T: Display> Entry<'a, T> {
    fn describe(&self) -> String {
        format!("{}: {}", self.name, self.value)
    }
}

fn load<R: Repository<String>>(repo: &R, key: &str) -> Option<String> {
    match repo.find(key) {
        Ok(value) if !value.is_empty() => Some(value),
        Ok(_) => None,
        Err(error) => {
            eprintln!("lookup failed: {error}");
            None
        }
    }
}

fn main() {
    let value = load(&LocalStore, "palette").unwrap_or_else(|| "missing".into());
    let entry = Entry {
        name: "string",
        value,
        state: State::Ready,
    };
    println!("{}; retry limit = {MAX_RETRIES}", entry.describe());

    for state in [
        entry.state,
        State::Busy {
            task: "index".into(),
        },
        State::Failed("offline".into()),
    ] {
        match state {
            State::Ready => println!("ready"),
            State::Busy { task } => println!("running {task}"),
            State::Failed(message) => eprintln!("failed: {message}"),
        }
    }
}
