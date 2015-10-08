Capture Params
========================

Overview
--------

The Capture Params gem adds a module that extends  [ActiveRecord::Base](http://api.rubyonrails.org/classes/ActiveRecord/Base.html) to add the automatic capturing of incoming params into a table called incoming_params.


Installation
------------

Add it to your Gemfile:

    gem 'capture_params', :git => 'https://github.com/jhaku/capture_params.git'

and run `bundle install` to install the new dependency.

Once installed you will need to restart your application for the gem to be loaded into the Rails
environment.

Usage
-----

Add 'param_capturable' to any active record class.  Set the new incoming_params attribute (added by the included module).  Once the incoming params are set the module will insert the incoming_paramable_type, incoming_paramable_id, and source_data fields into the incoming_params table in a after create callback on the class you are creating.