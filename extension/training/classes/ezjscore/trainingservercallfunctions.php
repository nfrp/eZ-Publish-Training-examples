<?php

/**
 * Implements methods called remotely by sending XHR calls
 *
 */
class TrainingServerCallFunctions
{
    /**
     * Returns block item XHTML
     *
     * @param mixed $args
     * @return array
     */
    public static function getNextItems( $args )
    {
        $http = eZHTTPTool::instance();
        $tpl = eZTemplate::factory();

        $result = array();

        $galleryID = $http->postVariable('gallery_id');
        $offset = $http->postVariable('offset');
        $limit = $http->postVariable('limit');

        $galleryNode = eZContentObjectTreeNode::fetch( $galleryID );
        if ( $galleryNode instanceof eZContentObjectTreeNode )
        {
            $params = array( 'Depth'   => 1,
                             'Offset'  => $offset,
                             'Limit'   => $limit );

            $pictureNodes = $galleryNode->subtree( $params );

            foreach( $pictureNodes as $validNode )
            {
                $tpl->setVariable('node', $validNode);
                $tpl->setVariable('view', 'block_item');
                $tpl->setVariable('image_class', 'blockgallery1');
                $content = $tpl->fetch('design:node/view/view.tpl');
                $result[] = $content;

                if ( $counter === $limit )
                    break;
            }
        }
        return $result;
    }
}

?>