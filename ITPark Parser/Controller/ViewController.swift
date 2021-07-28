import UIKit
import Alamofire
import SwiftSoup

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var updateDate: UILabel!

	var currentDate: Date = Date(timeIntervalSince1970: 0)
	var tableContent: JobList = JobList(jobs: [Job]())
	let dateFormatter = DateFormatter()
	
	// gets html
	func getHTML(){
		let url = "https://it.tpykt.ru/vakansii/"
		AF.request(url).responseString{ response in
			guard let html = response.value else{
				return
			}
			self.parseHTML(html)
			self.tableView.reloadData()
			//self.printTableContent(self.tableContent)
		}
	}

	func printTableContent(_ tableContent: JobList){
		for i in tableContent.jobs{
			print(i.contacts)
		}
	}

	func parseHTML(_ html: String){
		guard let doc: Document = try? SwiftSoup.parse(html) else{
			return
		}
		guard let element = try? doc.select("tbody tr") else{
			return
		}

		for row in element{
			var rowContent = [String]()
			guard let columns = try? row.select("td")else{
				return
			}
			for col in columns{
				guard let colContent = try? col.text()else{
					return
				}
				rowContent.append(colContent)
			}
			let job = Job(company: rowContent[0],
						  address: rowContent[1],
						  vacancy: rowContent[2],
						  requirements: rowContent[3],
						  salary: rowContent[4],
						  contacts: rowContent[5])
			self.tableContent.jobs.append(job)
		}
	}

	func updateCurrentDate(){
		currentDate = Date()
		print(currentDate)
		dateFormatter.locale = Locale(identifier: "ru_RU")
		dateFormatter.dateFormat = "d MMMM HH:mm"
		updateDate.text = "Обновлено " + dateFormatter.string(from: currentDate)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.getHTML()
		title = "Вакансии ИТ Парка"
		updateCurrentDate()
	}
}


// MARK: Data Source, Delegate
extension ViewController: UITableViewDataSource,UITableViewDelegate{

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableContent.jobs.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .subtitle , reuseIdentifier: nil)
		let job = tableContent.jobs[indexPath.row]
		cell.textLabel?.text = job.vacancy
		cell.detailTextLabel?.text = job.company
		cell.accessoryType = .disclosureIndicator
		return cell
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		"\(tableContent.jobs.count) вакансий"
	}

	func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		true
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = CellViewController()
		vc.job = tableContent.jobs[indexPath.row]
		tableView.deselectRow(at: indexPath, animated: true)

		navigationItem.largeTitleDisplayMode = .never
		navigationController?.pushViewController(vc, animated: true)
	}

}
