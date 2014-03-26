class ContactPresenter
  
  def initialize(contact)
    @contact = contact
  end
  
  def present
    presented = {
      "name" => @contact.name,
      "department" => @contact.department,
      "telephone" => @contact.telephone,
      "email" => @contact.email
    }
  end
end