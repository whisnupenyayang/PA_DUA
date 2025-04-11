<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class ForumResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            'id_forums' => $this->id_forums,
            'title' => $this->title,
            'deskripsi' =>  $this->deskripsi,
            'user_id' => $this->user_id,
            // 'images'=>'nando.jpg',
            'user_id'=> $this->user_id,
            'created_at' => $this->created_at,
            'updated-at' => $this->updated_at,
            'images' => $this->images,

        ];
    }
}
