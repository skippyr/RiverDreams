use super::error_treatment::print_error_message;
use std::
{
	process::exit,
	path::Path
};
use::sysinfo::
{
	System,
	SystemExt,
	Disk,
	DiskExt
};

fn does_disk_contain_operating_system(disk: &Disk) -> bool
{
	return disk.mount_point() == Path::new("/")
}

pub fn get_disk_usage_percentage() -> u8
{
	let mut system: System = System::new();
	system.refresh_disks_list();
	let mut total_disk_size_in_bytes: u64 = 0;
	let mut available_disk_size_in_bytes: u64 = 0;
	for disk in system.disks()
	{
		if !does_disk_contain_operating_system(disk)
		{ continue; }
		total_disk_size_in_bytes += disk.total_space();
		available_disk_size_in_bytes += disk.available_space();
	}
	if total_disk_size_in_bytes == 0
	{
		print_error_message("Could not get total disk size.");
		exit(1);
	}
	let used_disk_size_in_bytes: u64 = total_disk_size_in_bytes - available_disk_size_in_bytes;
	((used_disk_size_in_bytes as f32 / total_disk_size_in_bytes as f32) * 100.0) as u8
}
