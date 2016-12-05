require "togglapper/client_module"
module Togglapper
  module Params
    def user
      @user ||= client.me
    end

    def workspaces
      @workspaces ||= client.gc.my_workspaces(user)
    end

    def workspace(id: nil, name: nil)
      if id
        workspaces.find{ |work| work["id"] == id }
      elsif name
        workspaces.find{ |work| work["name"] == name }
      else
        workspaces.first
      end
    end

    def projects
      @projects ||= client.gc.my_projects
    end

    def project(id: nil, name: nil)
      if id
        projects.find{ |project| project["id"] == id }
      elsif name
        projects.find{ |project| project["name"] == name }
      else
        projects.first
      end
    end

    def tags
      @tags ||= client.gc.my_tags
    end

    def tag(id: nil, name: nil)
      if id
        tags.find{ |tag| tag["id"] == id }
      elsif name
        tags.find{ |tag| tag["name"] == name }
      else
        tags.first
      end
    end
  end
end
