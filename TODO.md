# TODO

In general, use the modules in <https://github.com/terraform-aws-modules> as a reference. All of the guidance and suggestions provided are based off of the years of effort and learnings that have gone into those modules

- [ ] Expose all arguments supported by the resource
- [ ] Follow the schema of the resource as much as possible - this is the API and what users will be most familiar with
- [ ] When using loop constructs, ensure that required values are required, and that default values do not surprise users
- [ ] Tags, tags, tags - always have to ensure that tags are passed to the resources
- [ ] Do not name resources/variables with implementation specifics - the App supports an IAM service role ARN argument which is currently being mapped to a CodeCommit specific IAM role. Make the role generic, but you can write configuration that allows users to opt into the components necessary for CodeCommit
- [ ] Additional or supplementary resources that are not directly consumed by the module require additional documentation to explain their intent and purpose. Consider moving these into a sub-module so that its clear these are not directly consumed as part of the main module, but play an optional, supporting role
- [ ] Variables should follow the form:

    ```hcl
    variable "example" {
      description = "This should be copied directly from the resource docs"
      type        = <type> # Do not over-constrain, this will cause users frustration
      default     = <default> # See below on default types
    }
      ```

      When the argument is optional, lean towards not providing an opinionated value unless there is a strong reason why that aids users to use that,
      When the type is an array, the default should be an empty list `[]` - this is used for conditional length checking and to clear the value if a user unsets
      When the type is a map/any, the default should be an empty map `{}` - this is used for conditional length checking and to clear the value if a user unsets
      All other types should default to `null`

- [ ] Where name conflicts can occur (IAM role, security groups, etc.), prefer to use a `name_prefix` as the default value but give users the ability to opt out of that behavior
- [ ] Use the IAM policy document data source - avoid using inline policies and `jsonencode`
- [ ] Give users the ability to toggle on/off all resource creation
- [ ] Examples must be deployable. If you require information from users to deploy the example, specify those required values as variables. Do not put in dummy placeholders - users will not know if those need to be changed to deploy the example and only cause confusion
- [ ] Examples should include all of the outputs supported by the module
- [ ] Examples are not a "how to x" - they are a demonstration, and validation, of how to use the module to achieve an outcome
