CREATE DATABASE fsdb;

USE fsdb;

CREATE TABLE fsdb_characterdata (
    id VARCHAR(255),
    business TEXT,
    skills TEXT,
    knownrecipes TEXT,
    computer TEXT,
    hatcoords TEXT,
    rating INT,
    PermData TEXT,
    LoginReward TEXT
);

CREATE TABLE fsdb_messenger (
    steamid VARCHAR(255),
    name VARCHAR(255),
    map TEXT,
    pos TEXT,
    ang TEXT,
    upvotes INT,
    downvotes INT,
    permanent BOOLEAN,
    alwaysshow BOOLEAN,
    msg TEXT
);

CREATE TABLE data (
    SteamID VARCHAR(255),
    IP VARCHAR(255),
    PrvData TEXT,
    PubData TEXT
);

CREATE TABLE fs_bans (
    steamid VARCHAR(255),
    ip VARCHAR(255),
    expireddate DATE,
    reason TEXT,
    dateof DATE,
    restrictip BOOLEAN
);

CREATE TABLE fsdb_user (
    id VARCHAR(255),
    model VARCHAR(255),
    items TEXT,
    steamid VARCHAR(255),
    org INT,
    last_name VARCHAR(255),
    adminrank INT,
    time_played INT,
    inv TEXT,
    first_name VARCHAR(255),
    cash INT,
    bankcash INT,
    ammo_sniper INT,
    bank_level INT
);

CREATE TABLE fs_orgs (
    id INT,
    name VARCHAR(255),
    motd TEXT,
    owner VARCHAR(255)
);

CREATE TABLE fsrp_global (
    time FLOAT
);

CREATE TABLE fsdb_models (
    id VARCHAR(255),
    police TEXT,
    paramedic TEXT
);

CREATE TABLE fsdb_jobtime (
    steamid VARCHAR(255),
    policetime INT,
    paramedictime INT,
    policerank INT,
    paramedicrank INT,
    mayortime INT,
    mayorrank INT
);

CREATE TABLE fsdb_globalvars (
    category VARCHAR(255),
    content TEXT,
    main TEXT
);

CREATE TABLE fs_vehicles (
    id VARCHAR(255),
    entname VARCHAR(255),
    bodygroups TEXT,
    skins TEXT,
    color TEXT
);

CREATE TABLE fsdb_physcol (
    id VARCHAR(255),
    col TEXT
);

CREATE TABLE company_eco (
    -- The structure of this table is not clear from the provided queries
);
