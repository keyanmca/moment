<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html style="height: 100%" xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Moment Video Server - http://momentvideo.org</title>
  <link rel="icon" type="image/vnd.microsoft.icon" href="favicon.ico"/>
  <style type="text/css">
    body {
      font-family: sans-serif;
      color: #dddddd;
    }
{{#MyPlayerPlaylist_ON}}
    .menuentry_one {
      background-color: #333333;
    }

    .menuentry_two {
      background-color: #222222;
    }

    div.menuentry_one:hover {
      background: #666666;
      cursor: pointer;
    }

    td.menuentry_one:hover {
      background: #666666;
      cursor: pointer;
    }

    div.menuentry_two:hover {
      background: #666666;
      cursor: pointer;
    }
{{/MyPlayerPlaylist_ON}}
  </style>
{{#MyPlayerPlaylist_ON}}
  <script type="text/javascript" src="jquery.js"></script>
  <script type="text/javascript">
    function togglePlaylist () {
      menu = document.getElementById ("menu");
      flash_div = document.getElementById ("flash_div");
      if (menu.style.display == "none") {
        menu.style.display = "block";
	flash_div.style.paddingRight = "200px";
      } else {
        menu.style.display = "none";
	flash_div.style.paddingRight = "0px";
      }
    }
  </script>
{{/MyPlayerPlaylist_ON}}
</head>
<body style="height: 100%; padding: 0; margin: 0; background-color: #000000">
  <div style="width: 100%; height: 100%; background-color: #000000;">
    <div id="flash_div" style="height: 100%;{{#MyPlayerPlaylist_ON}} padding-right: 200px;{{/MyPlayerPlaylist_ON}}">
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
	      width="100%"
	      height="100%"
	      id="MyPlayer"
	      align="middle">
	<param name="movie" value="MyPlayer.swf"/>
	<param name="allowScriptAccess" value="always"/>
	<param name="quality" value="high"/>
	<param name="scale" value="noscale"/>
	<param name="salign" value="lt"/>
	<param name="bgcolor" value="#000000"/>
	<param name="allowFullScreen" value="true"/>
	<param name="FlashVars" value="{{#MyPlayerAutoplay_OFF}}autoplay=0&{{/MyPlayerAutoplay_OFF}}playlist={{#MyPlayerPlaylist_ON}}1{{/MyPlayerPlaylist_ON}}{{#MyPlayerPlaylist_OFF}}0{{/MyPlayerPlaylist_OFF}}&buffer={{MyPlayerBuffer}}{{#MyPlayerAutoplayUri_ON}}&uri={{MyPlayerAutoplayUri}}&stream={{MyPlayerAutoplayStreamName}}{{/MyPlayerAutoplayUri_ON}}"/>
	<embed              FlashVars="{{#MyPlayerAutoplay_OFF}}autoplay=0&{{/MyPlayerAutoplay_OFF}}playlist={{#MyPlayerPlaylist_ON}}1{{/MyPlayerPlaylist_ON}}{{#MyPlayerPlaylist_OFF}}0{{/MyPlayerPlaylist_OFF}}&buffer={{MyPlayerBuffer}}{{#MyPlayerAutoplayUri_ON}}&uri={{MyPlayerAutoplayUri}}&stream={{MyPlayerAutoplayStreamName}}{{/MyPlayerAutoplayUri_ON}}"
	    src="MyPlayer.swf"
	    bgcolor="#000000"
	    width="100%"
	    height="100%"
	    name="MyPlayer"
	    quality="high"
	    align="middle"
	    scale="showall"
	    allowFullScreen="true"
	    allowScriptAccess="always"
	    type="application/x-shockwave-flash"
	    pluginspage="http://www.macromedia.com/go/getflashplayer"
	/>
	<!-- FIXME: scale="showall" may cause scaling problems -->
      </object>
    </div>
  </div>
{{#MyPlayerPlaylist_ON}}
  <div id="menu" style="width: 200px; height: 100%; background-color: #111111; border-left: 1px solid #222222; overflow: auto; position: absolute; top: 0px; right: 0px">
    {{#MyPlayerPlaylistHeader_ON}}
    <div style="padding: 1.2em; border-bottom: 5px solid #444444; vertical-align: bottom; text-align: center;">
      <span style="font-size: large; font-weight: bold; color: #777777;">{{MyPlayerPlaylistHeader}}</span>
    </div>
    {{/MyPlayerPlaylistHeader_ON}}
    <script type="text/javascript">
      var flash_initialized = false;

      var first_uri;
      var first_stream_name;

      function flashInitialized ()
      {
          flash_initialized = true;

          if (first_uri)
              document ["MyPlayer"].setFirstUri (first_uri, first_stream_name);
      }

      var menu = document.getElementById ("menu");

      $.get ("{{MyPlayerPlaylist}}",
	  {},
	  function (data) {
	      var playlist = eval ('(' + data + ')');
	      var class_one = "menuentry_one";
	      var class_two = "menuentry_two";
	      var cur_class = class_one;

	      for (var i = 0; i < playlist.length; ++i) {
		  var item = playlist [i];
		  var entry = document.createElement ("div");

		  entry.className = cur_class;
		  entry.style.padding = "10px";
		  entry.style.textAlign = "left";
		  entry.style.verticalAlign = "bottom";
		  entry.onclick =
			  (function (uri, stream_name) {
				   return function () {
					   document ["MyPlayer"].setSource (uri, stream_name);
				   };
			   }) (item [1], item [2]);
		  entry.innerHTML = item [0];
		  menu.appendChild (entry);

		  if (cur_class == class_one)
		      cur_class = class_two;
		  else
		      cur_class = class_one;
	      }

	      first_uri         = (playlist [0]) [1];
	      first_stream_name = (playlist [0]) [2];
	      if (first_uri && flash_initialized) {
		  document ["MyPlayer"].setFirstUri (first_uri, first_stream_name);
              }
	  }
      );
    </script>
  </div>
{{/MyPlayerPlaylist_ON}}
</body>
</html>

