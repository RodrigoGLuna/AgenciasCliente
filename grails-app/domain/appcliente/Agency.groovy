package appcliente

class Agency {
    String address_line
    String city
    String country
    String location
    String other_info
    String state
    String zip_code
    Integer agency_code
    String description
    String disabled
    Double distance
    String id
    String payment_method_id
    String phone
    String site_id
    String terminal

    Agency(String address_line, String city, String country, String location, String other_info, String state, String zip_code, Integer agency_code, String description, String disabled, Double distance, String id, String payment_method_id, String phone, String site_id, String terminal) {
        this.address_line = address_line
        this.city = city
        this.country = country
        this.location = location
        this.other_info = other_info
        this.state = state
        this.zip_code = zip_code
        this.agency_code = agency_code
        this.description = description
        this.disabled = disabled
        this.distance = distance
        this.id = id
        this.payment_method_id = payment_method_id
        this.phone = phone
        this.site_id = site_id
        this.terminal = terminal
    }
    static constraints = {

        agency_code nullable: false
        agency_code unique: true
        id nullable: false
        id unique: true

    }
}
