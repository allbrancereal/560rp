CREATE TABLE 'ip_intel' (
  'steamid' text NOT NULL,
  'ip' text,
  'name' text,
  'first_seen' bigint(20) DEFAULT '0',
  'last_seen' bigint(20) DEFAULT '0',
  'num_seen' int(11) DEFAULT '0',
  'unique_id' text,
  'rp_name' text,
  'play_time' bigint(20) DEFAULT '0',
  'strikes' int(11) DEFAULT '0',
  PRIMARY KEY ('steamid'(20))
)
 
CREATE TABLE 'perp_bname' (
  'name' text NOT NULL
)
 
CREATE TABLE 'perp_fuel' (
  'uid' varchar(11) NOT NULL,
  '1' int(11) NOT NULL DEFAULT '10000',
  '2' int(11) NOT NULL DEFAULT '10000',
  '3' int(11) NOT NULL DEFAULT '10000',
  '4' int(11) NOT NULL DEFAULT '10000',
  '5' int(11) NOT NULL DEFAULT '10000',
  '6' int(11) NOT NULL DEFAULT '10000',
  '7' int(11) NOT NULL DEFAULT '10000',
  '8' int(11) NOT NULL DEFAULT '10000',
  '9' int(11) NOT NULL DEFAULT '10000',
  '10' int(11) NOT NULL DEFAULT '10000',
  '11' int(11) NOT NULL DEFAULT '10000',
  '12' int(11) NOT NULL DEFAULT '10000',
  '13' int(11) NOT NULL DEFAULT '10000',
  '14' int(11) NOT NULL DEFAULT '10000',
  '15' int(11) NOT NULL DEFAULT '10000',
  '16' int(11) NOT NULL DEFAULT '10000',
  '17' int(11) NOT NULL DEFAULT '10000',
  '18' int(11) NOT NULL DEFAULT '10000',
  '19' int(11) NOT NULL DEFAULT '10000',
  '20' int(11) NOT NULL DEFAULT '10000',
  '21' int(11) NOT NULL DEFAULT '10000',
  '22' int(11) NOT NULL DEFAULT '10000',
  '23' int(11) NOT NULL DEFAULT '10000',
  '24' int(11) NOT NULL DEFAULT '10000',
  '25' int(11) NOT NULL DEFAULT '10000',
  '26' int(11) NOT NULL DEFAULT '10000',
  '27' int(11) NOT NULL DEFAULT '10000',
  '28' int(11) NOT NULL DEFAULT '10000',
  '29' int(11) NOT NULL DEFAULT '10000',
  '30' int(11) NOT NULL DEFAULT '10000',
  '31' int(11) NOT NULL DEFAULT '10000',
  '32' int(11) NOT NULL DEFAULT '10000',
  '33' int(11) NOT NULL DEFAULT '10000',
  '34' int(11) NOT NULL DEFAULT '10000',
  '35' int(11) NOT NULL DEFAULT '10000',
  '36' int(11) NOT NULL DEFAULT '10000',
  '37' int(11) NOT NULL DEFAULT '10000',
  '38' int(11) NOT NULL DEFAULT '10000',
  '39' int(11) NOT NULL DEFAULT '10000',
  '40' int(11) NOT NULL DEFAULT '10000',
  '41' int(11) NOT NULL DEFAULT '10000',
  '42' int(11) NOT NULL DEFAULT '10000',
  '43' int(11) NOT NULL DEFAULT '10000',
  '44' int(11) NOT NULL DEFAULT '10000',
  '45' int(11) NOT NULL DEFAULT '10000',
  '46' int(11) NOT NULL DEFAULT '10000',
  '47' int(11) NOT NULL DEFAULT '10000',
  '48' int(11) NOT NULL DEFAULT '10000',
  '49' int(11) NOT NULL DEFAULT '10000',
  '50' int(11) NOT NULL DEFAULT '10000',
  '51' int(11) NOT NULL DEFAULT '10000',
  '52' int(11) NOT NULL DEFAULT '10000',
  '53' int(11) NOT NULL DEFAULT '10000',
  '54' int(11) NOT NULL DEFAULT '10000',
  '55' int(11) NOT NULL DEFAULT '10000',
  PRIMARY KEY ('uid')
)
 
CREATE TABLE 'perp_organization' (
  'name' text NOT NULL,
  'motd' text NOT NULL,
  'owner' text NOT NULL,
  'id' int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY ('id')
)
 
CREATE TABLE 'perp_physcol' (
  'id' varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  'col' varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY ('id')
)
 
CREATE TABLE 'perp_system' (
  'key' text NOT NULL,
  'value' text NOT NULL,
  PRIMARY KEY ('key'(15))
)
 
CREATE TABLE 'perp_users' (
  'uid' bigint(11) NOT NULL,
  'id' text NOT NULL,
  'steamid' text NOT NULL,
  'blacklists' text NOT NULL,
  'rp_name_first' text NOT NULL,
  'rp_name_last' text NOT NULL,
  'time_played' bigint(20) NOT NULL,
  'cash' bigint(20) NOT NULL,
  'model' text NOT NULL,
  'items' text NOT NULL,
  'skills' text NOT NULL,
  'genes' text NOT NULL,
  'formulas' text NOT NULL,
  'organization' int(11) NOT NULL DEFAULT '0',
  'bank' bigint(20) NOT NULL,
  'vehicles' text NOT NULL,
  'ringtones' text NOT NULL,
  'ammo_pistol' int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  'ammo_rifle' int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  'ammo_shotgun' int(11) unsigned zerofill NOT NULL DEFAULT '00000000000',
  'ringtone' int(11) NOT NULL DEFAULT '1',
  'last_played' text NOT NULL,
  'fuelleft' int(11) NOT NULL DEFAULT '10000',
  'lastcar' text NOT NULL,
  'rank' int(11) DEFAULT '10',
  PRIMARY KEY ('uid','id'(15),'steamid'(15))
)
 
CREATE TABLE 'perp_warehouse' (
  'steamid' text NOT NULL,
  'itemid' text NOT NULL,
  'amount' text NOT NULL
)kkaptain
lordbeaverbrook
film
yms
 Badenbaden12
CREATE TABLE 'perp_warehouse_org' (
  'id' text NOT NULL,
  'itemid' text NOT NULL,
  'amount' text NOT NULL
)
 email: sk8tra@gmail.com
 pw: UnsignedInt12
 sq: mario
 date of creation: October 11 2011
 original account email: superlink123@yahoo.de
 my contact email: sk8tra@gmail.com
CREATE TABLE 'perp_vip' (
  'steamid' char(30) NOT NULL,
  'type' int(11) NOT NULL,
  'days' int(11) NOT NULL,
  PRIMARY KEY ('steamid')
)
 
CREATE TABLE 'rp_jobplaytimes' (
  'steamid' text,
  'Ctime' int(11) DEFAULT NULL,
  'Ptime' int(11) DEFAULT NULL,
  'Ftime' int(11) DEFAULT NULL,
  'Stime' int(11) DEFAULT NULL,
  'Mtime' int(11) DEFAULT NULL
)