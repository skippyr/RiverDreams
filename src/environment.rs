use std::env::var;

pub struct EnvironmentVariables;

impl EnvironmentVariables
{
	pub fn is_to_use_fallback_text() -> bool
	{
		match var("RIVER_DREAMS_USE_FALLBACK_TEXT")
		{
			Ok(value) =>
			{ value == "1" }
			Err(_error) =>
			{ false }
		}
	}

	pub fn get_pwd() -> String
	{
		match var("PWD")
		{
			Ok(value) =>
			{ value }
			Err(_error) =>
			{ String::from("/") }
		}
	}
}

