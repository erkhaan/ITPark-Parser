import Foundation

struct Job{
	let company: String
	let address: String
	let vacancy: String
	let requirements: String
	let salary: String
	let contacts: String
}

struct JobList{
	var jobs: [Job]
}
