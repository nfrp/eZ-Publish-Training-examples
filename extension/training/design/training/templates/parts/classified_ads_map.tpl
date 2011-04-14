{def $seed = rand( 0, 10000 )}
{if is_unset( $ads )}
    {def $ads = array()}
{/if}
{run-once}
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key={ezini('SiteSettings','GMapsKey')}" type="text/javascript"></script>
<script type="text/javascript">
{literal}
function eZGmapLocation_ClassifiedMapView( seed )
{
    if ( GBrowserIsCompatible() ) 
    {
		var _createMarker = function ( lat, lng, info, bounds, icon )
		{
		    var point  = new GLatLng( lat, lng );
		    var marker = new GMarker( point, icon );
		    GEvent.addListener( marker, "click", function() 
		    {
		        marker.openInfoWindowHtml( info );
		    });
		    
		    if ( bounds )
		    {
		        bounds.extend( point );
		    }
		    return marker;      
		};  

        var map = new GMap2( document.getElementById( 'ezgml-map-' + seed ) );
        map.addControl( new GMapTypeControl() );
        map.addControl( new GLargeMapControl() );
        map.setMapType( G_NORMAL_MAP );
        map.setCenter( new GLatLng(0,0), 0 );
        var bounds = new GLatLngBounds();
        
        {/literal}
        {foreach $ads as $ad}
            map.addOverlay( _createMarker( '{$ad.coordinates.0}', '{$ad.coordinates.1}', unescape( '{$ad.markerText}' ), bounds ) );        
        {/foreach}        
        {literal}
        
        var center = bounds.getCenter();
        var zoom = map.getBoundsZoomLevel( bounds );
        map.setCenter( center, zoom );        
    }
}
{/literal}
</script>
{/run-once}

<script type="text/javascript">
<!--

if ( window.addEventListener )
    window.addEventListener('load', function(){ldelim} eZGmapLocation_ClassifiedMapView( {$seed} ) {rdelim}, false);
else if ( window.attachEvent )
    window.attachEvent('onload', function(){ldelim} eZGmapLocation_ClassifiedMapView( {$seed} ) {rdelim} );

-->
</script>

<div id="ezgml-map-{$seed}" style="width: 450px; height: 400px;"></div>