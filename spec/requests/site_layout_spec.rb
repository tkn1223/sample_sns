require 'rails_helper'

RSpec.describe "SiteLayout", type: :request do
    describe "Get / (root_path)" do
        before { get root_path }

        it "renders the home template" do
            expect(response).to render_template(:home)
        end

        it "includes correct links" do
            expect(response.body).to include("href=\"#{root_path}\"")
            expect(response.body).to include("href=\"#{help_path}\"")
            expect(response.body).to include("href=\"#{about_path}\"")
            expect(response.body).to include("href=\"#{contact_path}\"")
            expect(response.body).to include("href=\"#{signup_path}\"")
        end
    end
end
