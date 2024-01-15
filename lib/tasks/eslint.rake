desc 'Run ESLint'
task eslint: :environment do
  sh 'yarn lint:js'
end

namespace :eslint do
  desc 'Autocorrect ESLint offenses'
  task autocorrect: :environment do
    sh 'yarn fix:js'
  end
end
