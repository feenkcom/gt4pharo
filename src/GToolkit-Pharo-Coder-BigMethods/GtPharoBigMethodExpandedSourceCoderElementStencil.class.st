"
I create a basic collapsed coder element used by {{gtClass:GtPharoBigMethodExpandableSourceCoderElement}}. 
Such collapsed coder element is created in the {{gtMethod:GtPharoBigMethodExpandableSourceCoderElement>>#newCollapsedElement}} method. 
Users can set their own stencil using {{gtMethod:GtPharoBigMethodExpandedSourceCoderElementStencil class>>#defaultStencil:}}. 

"
Class {
	#name : #GtPharoBigMethodExpandedSourceCoderElementStencil,
	#superclass : #GtCoderElementStencil,
	#category : #'GToolkit-Pharo-Coder-BigMethods-Coder'
}

{ #category : #'api - instantiation' }
GtPharoBigMethodExpandedSourceCoderElementStencil >> defaultElement [
	^ GtPharoBigMethodExpandedSourceCoderElement new
]
