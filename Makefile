
config:
	ruby ./configuration.rb 
minor:
	bundle exec fastlane run increment_version_number bump_type:"minor"
patch:
	bundle exec fastlane run increment_version_number bump_type:"patch"
set_version:
	bundle exec fastlane run increment_version_number version_number:$(arg1)
increment_build:
	bundle exec fastlane run increment_build_number

format:
	swiftlint autocorrect --format
 
prebuild:
	export LC_ALL=en_US.UTF-8
	export LANG=en_US.UTF-8
	bundle install || true


bootstrap: dependencies
	swiftlint 2>/dev/null || brew install swiftlint
	brew link --overwrite swiftlint

	swiftgen 2>/dev/null || brew install swiftgen

dependencies: submodules secrets
	bundle || gem install bundle --user
	bundle install

submodules:
	git submodule sync --recursive || true
	git submodule update --init --recursive || true

secrets: submodules
	-@rm -rf DecadeOfMovies/Configurations/Secrets
	mkdir -p DecadeOfMovies/Configurations/Secrets

	if [ -d Submodule/Secrets/iOS/Secrets ]; \
	then \
		cp -n -R Submodule/Secrets/iOS/Secrets/DecadeOfMovies/Configurations/Secrets/ || true; \
	else \
	cp -n -R Fake/DecadeOfMovies/Configurations/Secrets/ || true; \
	fi


sourcekitten:
	sourcekitten doc -- -workspace DecadeOfMovies.xcworkspace -scheme DecadeOfMovies > ./sourcekittendocs.json
