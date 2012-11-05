# DelayedSunspot [![endorse](http://api.coderwall.com/anthonator/endorsecount.png)](http://coderwall.com/anthonator)

Adds support for indexing objects asynchronously using [Sunspot](https://github.com/sunspot/sunspot) and [Delayed Job](https://github.com/collectiveidea/delayed_job).

[![Build Status](https://secure.travis-ci.org/anthonator/delayed_sunspot.png)](http://travis-ci.org/anthonator/delayed_sunspot)

## Installation

Add this line to your application's Gemfile:

    gem 'delayed_sunspot'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install delayed_sunspot

## Usage

You will need to configure Sunspot to use delayed_sunspot's session proxy in order to push Sunspot commands through Delayed Job.

```ruby
Sunspot.session = Sunspot::SessionProxy::DelayedJobSessionProxy.new(Sunspot.session)
```

If you're using Rails put the above line of code in an initializer.

## ZOMG! WHY AREN'T MY OBJECTS BEING INDEXED?!

If you're using the sunspot_rails gem you might have noticed that the objects you've been indexing aren't coming back in your search results. This is due to the sunspot_rails gem being configured to autocommit indexes through a controller hook. This functionality doesn't exist when indexing outside of a controller.

You can enable autocommit by putting the following code in your solrconfig.xml under the updateHandler section:

```xml
<autoCommit>
    <maxDocs>10000</maxDocs> <!-- maximum uncommited docs before autocommit triggered -->
    <maxTime>15000</maxTime> <!-- maximum time (in MS) after adding a doc before an autocommit is triggered -->
</autoCommit>
```

To find out more about autocommits [read the Solr documentation](http://wiki.apache.org/solr/SolrConfigXml#Update_Handler_Section)

If you've already configured Solr for autocommits you're good to go.

## Asynchronous Commands

batch  
commit  
commit_if_delete_dirty  
commit_if_dirty  
index  
index!  
remove  
remove!  
remove_all  
remove_all!  
remove_by_id  
remove_by_id!  

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
