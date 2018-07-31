# # encoding: utf-8

# Inspec test for recipe git_cookbook::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('httpd') do
  it { should be_installed }
end
