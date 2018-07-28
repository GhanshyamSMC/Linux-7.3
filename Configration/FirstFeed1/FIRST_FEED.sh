#!/bin/sh
cd /FirstFeed/
java -cp "bin/*" -DSettingsFilePath=/FirstFeed/ com.algo.adaptor.nse.md.broadcast.FeedBroadcaster


