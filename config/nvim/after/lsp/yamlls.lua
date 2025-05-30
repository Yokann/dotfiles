return {
    settings = {
        yaml = {
            -- validate = true,
            -- disable the schema store
            schemaStore = {
                enable = false,
                url = "",
            },
            schemas = require('schemastore').yaml.schemas()
        }
    }
}
