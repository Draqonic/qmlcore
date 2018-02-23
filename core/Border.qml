/// class controlling border rendering
Object {
	property int width;		///< width of the border
	property color color: "black";	///< color of the border
	property enum style { None, Hidden, Dotted, Dashed, Solid, Double, Groove, Ridge, Inset, Outset, Initial }: Solid; ///< style of the border

	property BorderSide left:		BorderSide	{ name: "left"; }		///< left border side
	property BorderSide right:		BorderSide	{ name: "right"; }		///< right border side
	property BorderSide top:		BorderSide	{ name: "top"; }		///< top border side
	property BorderSide bottom:		BorderSide	{ name: "bottom"; }		///< bottom border side
}
