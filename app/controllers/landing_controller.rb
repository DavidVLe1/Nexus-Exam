class LandingController < ApplicationController
  def index
    @breadcrumbs = [
      { content: "Home", href: root_path }
    ]
  end
end
