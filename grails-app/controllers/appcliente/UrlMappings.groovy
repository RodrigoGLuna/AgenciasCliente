package appcliente

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: "cliente")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
