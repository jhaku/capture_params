Capture Params
========================

Overview
--------
We here at haku found it necessary to capture the params as they arrive at the controller.  We were looking these up in logs but found it to be in efficient, finding ourselves greping across multiple files and since we only keep a finite number of log files we sometimes lost the record of the incoming service call.

The Capture Params gem adds a module that extends  [ActiveRecord::Base](http://api.rubyonrails.org/classes/ActiveRecord/Base.html) to allow for the automatic capturing of incoming params into a table called incoming_params.  


Installation
------------

Add it to your Gemfile:

    gem 'capture_params', :git => 'https://github.com/jhaku/capture_params.git'

and run `bundle install` to install the new dependency.

Once installed you will need to restart your application for the gem to be loaded into the Rails
environment.

Usage
-----

Add 'param_capturable' to any active record class.  Set the new incoming_params attribute (added by the included module).  Once the incoming params are set the module will insert the incoming_paramable_type, incoming_paramable_id, and source_data fields into the incoming_params table (see the migration below) in an after_create callback in the class you are creating.  If the incoming_params attribute is not set, nothing will happen on create.  The incoming params are caputured in the source_data field as a string.

Migration
---------

Add this migration and run it to create the table for capturing your params data

class CreateIncomingParams < ActiveRecord::Migration
  def up
    create_table :incoming_params do |t|
  	# Adding fields for table incoming_params
      t.userstamps
      t.timestamps      
      t.string    :incoming_paramable_type,     :null => false
      t.integer   :incoming_paramable_id,       :null => false
      t.text      :source_data,                 :null => false
  	end
    
    # Adding constraints for incoming_params
      sql_fk = %Q(CREATE INDEX ip_ip_type_ip_id_idx ON incoming_params using btree (incoming_paramable_type, incoming_paramable_id);)    
      execute sql_fk
  end

  def down
    sql_fk = %Q(DROP INDEX ip_ip_type_ip_id_idx;
                )    
    execute sql_fk
    drop_table :incoming_params
  end
end