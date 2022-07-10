class Repository < ApplicationRecord
  require 'octokit'


  def self.load_from_github
    Octokit.auto_paginate = true
    octo_client = Octokit::Client.new(:access_token => ENV["GITHUB_KEY"])

    organizations = octo_client.organizations
    organizations.each do |organization|
      if organization[:login] == "StrongMind"
        @organization_repositories = octo_client.org_repos(organization[:login], {:type => 'all'})
      end
    end

    @organization_repositories.each do |organization_repository|
      # puts organization_repository[:name]
      self.upsert({name: organization_repository[:name], description: organization_repository[:description]})
    end

  end
end
