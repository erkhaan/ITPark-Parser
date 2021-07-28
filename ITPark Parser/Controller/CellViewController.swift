import UIKit

class CellViewController: UIViewController {


	@IBOutlet weak var vacancyLabel: UILabel!
	@IBOutlet weak var salaryLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	@IBOutlet weak var companyLabel: UILabel!
	@IBOutlet weak var requirementsLabel: UILabel!

	@IBOutlet weak var contactLabel: UILabel!

	var job: Job = Job(company: "", address: "", vacancy: "", requirements: "", salary: "", contacts: "")

    override func viewDidLoad() {
        super.viewDidLoad()
		vacancyLabel?.text = job.vacancy
		salaryLabel?.text = job.salary
		addressLabel?.text = job.address
		companyLabel?.text = job.company
		requirementsLabel?.text = job.requirements
		contactLabel?.text = job.contacts
    }

	override func viewDidDisappear(_ animated: Bool) {
		
	}
}
