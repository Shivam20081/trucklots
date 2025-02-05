# 400_integration

module "gmi_data_factory_pipeline" {
  source          = "../../modules/adf_pipeline"
  Env             = var.Env
  tenant          = "gmi"
  data_factory_id = data.terraform_remote_state.datalake.outputs.data_factory_id
  notebook_activities = [{
      name      = "gmi-primary-QC"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath  = "/Users/devops@greensight.ai/gmi-primary-QC"
      dynamic_base_parameters = {
          file_path= {
              value= "@pipeline().globalParameters.gmi_file_path",
              type = "Expression"
          },
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "faile-state-primary-QC"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/gmi-sql-db-Update"
      depends_on            = "Failed"
      depends_on_resource   = "gmi-primary-QC"
      dynamic_base_parameters = {
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "gmi-transformation"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/gmi-transformation"
      depends_on            = "Succeeded"
      depends_on_resource   = "gmi-primary-QC"
      dynamic_base_parameters = {
          file_path= {
              "value"= "@activity('gmi-primary-QC').output.runOutput.file_path",
              "type"= "Expression"
          },
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "faile-state-transformation"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/gmi-sql-db-Update"
      depends_on            = "Failed"
      depends_on_resource   = "gmi-transformation"
      dynamic_base_parameters = {
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "gmi-secondary-QC"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/gmi-secondary-QC"
      depends_on            = "Succeeded"
      depends_on_resource   = "gmi-transformation"
      dynamic_base_parameters = {
          file_path= {
              "value"= "@activity('gmi-transformation').output.runOutput.file_path",
              "type"= "Expression"
          },
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "faile-state-secondary-QC"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/gmi-sql-db-Update"
      depends_on            = "Failed"
      depends_on_resource   = "gmi-secondary-QC"
      dynamic_base_parameters = {
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "gmi-db-update"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/gmi-sql-db-Update"
      depends_on            = "Succeeded"
      depends_on_resource   = "gmi-secondary-QC"
      dynamic_base_parameters = {
          file_path= {
              "value"= "@activity('gmi-secondary-QC').output.runOutput.file_path",
              "type"= "Expression"
          },
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "faile-state-db-update"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/gmi-sql-db-Update"
      depends_on            = "Failed"
      depends_on_resource   = "gmi-db-update"
      dynamic_base_parameters = {
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    }
  ]
}

module "pepsi_data_factory_pipeline" {
  source          = "../../modules/adf_pipeline"
  Env             = var.Env
  tenant          = "pepsi"
  data_factory_id = data.terraform_remote_state.datalake.outputs.data_factory_id
  notebook_activities = [{
      name      = "pepsi-primary-QC"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath  = "/Users/devops@greensight.ai/pepsi-primary-QC"
      dynamic_base_parameters = {
          file_path= {
              value= "@pipeline().globalParameters.pepsi_file_path",
              type = "Expression"
          },
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "faile-state-primary-QC"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/pepsi-sql-db-Update"
      depends_on            = "Failed"
      depends_on_resource   = "pepsi-primary-QC"
      dynamic_base_parameters = {
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "pepsi-transformation"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/pepsi-transformation"
      depends_on            = "Succeeded"
      depends_on_resource   = "pepsi-primary-QC"
      dynamic_base_parameters = {
          file_path= {
              "value"= "@activity('pepsi-primary-QC').output.runOutput.file_path",
              "type"= "Expression"
          },
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "faile-state-transformation"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/pepsi-sql-db-Update"
      depends_on            = "Failed"
      depends_on_resource   = "pepsi-transformation"
      dynamic_base_parameters = {
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "pepsi-secondary-QC"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/pepsi-secondary-QC"
      depends_on            = "Succeeded"
      depends_on_resource   = "pepsi-transformation"
      dynamic_base_parameters = {
          file_path= {
              "value"= "@activity('pepsi-transformation').output.runOutput.file_path",
              "type"= "Expression"
          },
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "faile-state-secondary-QC"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/pepsi-sql-db-Update"
      depends_on            = "Failed"
      depends_on_resource   = "pepsi-secondary-QC"
      dynamic_base_parameters = {
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "pepsi-db-update"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/pepsi-sql-db-Update"
      depends_on            = "Succeeded"
      depends_on_resource   = "pepsi-secondary-QC"
      dynamic_base_parameters = {
          file_path= {
              "value"= "@activity('pepsi-secondary-QC').output.runOutput.file_path",
              "type"= "Expression"
          },
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    },
    {
      name      = "faile-state-db-update"
      type      = "DatabricksNotebook"
      link_name = "service link for azure databrick"
      rootPath  = "/"
      notebookPath          = "/Users/devops@greensight.ai/pepsi-sql-db-Update"
      depends_on            = "Failed"
      depends_on_resource   = "pepsi-db-update"
      dynamic_base_parameters = {
          run_id= {
              value= "@pipeline().RunId",
              type= "Expression"
          } 
      }
    }
  ]
}