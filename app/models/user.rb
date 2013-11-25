class User < ActiveRecord::Base
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 } 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false } 
  has_secure_password
  validates :password, length: { minimum: 6 }
end

#
#
# NOTES ON MODEL FILES AND ACTIVE RECORDS
#
#

# This is the model file for the User model. it lives in App, alongside Controller and View.
# The model's job is to interface with the database.  Any low level database
# operations are done here.  The model gets the data to give to the Controller, 

#  DATA => MODEL => CONTROLLER 

# The model inherits from ActiveRecord::Base, which contains Ruby's Database magic 
# stuff that runs SQL statements directly.  These are the DBI package and ExecSQL functions in Perl.
# At Zachys, this stuff was known as "Business Logic" and it involved stored procedures and such.

# IN GENERAL in Ruby that stuff is taken care of for you.  You simply manipulate the data once it 
# has been put into Ruby as an array.  This happens in the controller.  The model simply 
# hands it over. Altough, we do need to control some things about how the database does things, 
# so we must come here. 

# In this file are CONTRAINTS, which is database stuff.  It's code that needs to be run on the 
# database side, so it is put here. 
# It is executed before the data is put into the database (as demonstrated by before_save)

#  CONTROLLER => MODEL ={RUN THIS CODE}> DATABASE 

# That article we found recognized this is "the chubby guy in the back".  Good analogy.
# I like to think of the database as a ferocious creature that must be handled in a particular
# way or it gets mad and does very bad things.  As such, it takes specialized code to work with it,
# for this reason, we hand the job over to the master "ActiveRecord::Base"