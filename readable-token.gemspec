# frozen_string_literal: true

require_relative "lib/readable/token/version"

Gem::Specification.new do |spec|
  spec.name = "readable-token"
  spec.version = Readable::Token::VERSION
  spec.authors = ["yutoo89"]
  spec.email = ["yuta.o.note@gmail.com"]

  spec.summary = "A gem to generate readable random tokens"
  spec.description = "This gem generates random tokens that are easy to read and distinguish. It is designed for scenarios where tokens need to be printed or entered manually."
  spec.homepage = "https://github.com/yutoo89"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yutoo89/readable-token"
  spec.metadata["changelog_uri"] = "https://github.com/yutoo89/readable-token/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"
end
