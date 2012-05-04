# This file is copied/adapted from the Three.js cube geometry example
# [https://github.com/mrdoob/three.js/blob/master/examples/canvas_geometry_cube.html]
#
# I removed a few callbacks I don't need, and put the javascript into
# this separate file, and rewrote it into pig-coffeescript. I sourced
# this file from index.html. So now our html is doing both WebGL and
# GA at the same time.

# hack to make these five vars be "global" in some sense so all our
# fns below can see them. How is one supposed to do this?
plane = []
cube = []
renderer = []
scene = []
camera = []

targetRotation = 0
targetRotationOnMouseDown = 0

mouseX = 0
mouseXOnMouseDown = 0

windowHalfX = window.innerWidth * 0.5
windowHalfY = window.innerHeight * 0.5

init = ->
    container = document.createElement( 'div' );
    document.body.appendChild( container )

    info = document.createElement( 'div' )
    info.style.position = 'absolute'
    info.style.top = '10px'
    info.style.width = '100%'
    info.style.textAlign = 'center'
    info.innerHTML = 'Drag to spin the cube'
    container.appendChild( info )

    scene = new THREE.Scene()

    camera = new THREE.PerspectiveCamera( 70, window.innerWidth / window.innerHeight, 1, 1000 )
    camera.position.y = 150
    camera.position.z = 500
    scene.add( camera )

    materials = (new THREE.MeshBasicMaterial( { color: Math.random() * 0xffffff } ) for i in [0 .. 6])

    cube = new THREE.Mesh( new THREE.CubeGeometry( 200, 200, 200, 1, 1, 1, materials ), new THREE.MeshFaceMaterial() )
    cube.position.y = 150
    scene.add( cube )

    # Plane

    plane = new THREE.Mesh( new THREE.PlaneGeometry( 200, 200 ), new THREE.MeshBasicMaterial( { color: 0xe0e0e0 } ) )
    scene.add( plane )

    renderer = new THREE.CanvasRenderer()
    renderer.setSize( window.innerWidth, window.innerHeight )

    container.appendChild( renderer.domElement )


    document.addEventListener( 'mousedown', onDocumentMouseDown, false )


onDocumentMouseDown = (event) ->

    event.preventDefault()

    document.addEventListener( 'mousemove', onDocumentMouseMove, false )
    document.addEventListener( 'mouseup', onDocumentMouseUp, false )
    document.addEventListener( 'mouseout', onDocumentMouseOut, false )

    mouseXOnMouseDown = event.clientX - windowHalfX
    targetRotationOnMouseDown = targetRotation

    # added this to test out what I'm doing
    $('#myclicktext').text('You touched the cube!')


onDocumentMouseMove = (event) ->

    mouseX = event.clientX - windowHalfX

    targetRotation = targetRotationOnMouseDown + ( mouseX - mouseXOnMouseDown ) * 0.02


onDocumentMouseUp = (event) ->

    document.removeEventListener( 'mousemove', onDocumentMouseMove, false )
    document.removeEventListener( 'mouseup', onDocumentMouseUp, false )
    document.removeEventListener( 'mouseout', onDocumentMouseOut, false )


onDocumentMouseOut = (event) ->

    document.removeEventListener( 'mousemove', onDocumentMouseMove, false )
    document.removeEventListener( 'mouseup', onDocumentMouseUp, false )
    document.removeEventListener( 'mouseout', onDocumentMouseOut, false )

animate = ->

    requestAnimationFrame( animate )

    render()

render = ->

    plane.rotation.y = cube.rotation.y += ( targetRotation - cube.rotation.y ) * 0.05
    renderer.render( scene, camera )

root = exports ? this
root.init = init
root.animate = animate
