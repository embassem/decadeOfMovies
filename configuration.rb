
require 'xcodeproj'
project_path = 'DecadeOfMovies.xcodeproj'
project = Xcodeproj::Project.open(project_path)
app = project.targets[0]
puts app.name
app.build_configurations.each do |config|
config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = '$(APP_BUNDLE_IDENTIFIER)'
config.build_settings['DEVELOPMENT_TEAM'] = ''
config.build_settings['ASSETCATALOG_COMPILER_APPICON_NAME'] = '$(APP_ICON)'
end


project::save()
