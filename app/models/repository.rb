class Repository < ApplicationRecord
  require 'octokit'


  def self.load_from_github
    Octokit.auto_paginate = true
    octo_client = Octokit::Client.new(:access_token => Rails.application.credentials.github[:token])

    organizations = octo_client.organizations
    organizations.each do |organization|
      if organization[:login] == "StrongMind"
        @organization_repositories = octo_client.org_repos(organization[:login], {:type => 'all'})
      end
    end

    @organization_repositories.each do |organization_repository|
      # puts organization_repository[:name]
      self.upsert({name: organization_repository[:name],
                            description: organization_repository[:description],
                            github_id: organization_repository[:id],
                            full_name: organization_repository[:full_name],
                            private: organization_repository[:private],
                            github_created_at: organization_repository[:created_at],
                            github_updated_at: organization_repository[:updated_at],
                            github_push_at: organization_repository[:push_at],
                            default_branch: organization_repository[:default_branch]
                  })
    end

  end

  def get_readme
    Octokit.auto_paginate = true
    octo_client = Octokit::Client.new(:access_token => Rails.application.credentials.github[:token])
    octo_client.readme(self.full_name)
  end

end
