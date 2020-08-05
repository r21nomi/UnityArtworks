using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Mover : MonoBehaviour
{
    public float offset = 0;
    private float initialY = 0;

    // Start is called before the first frame update
    void Start()
    {
        initialY = transform.position.y;
    }

    // Update is called once per frame
    void Update()
    {
        var pos = transform.position;
        pos.y = initialY + initialY * (float) Math.Sin(Time.time + offset) * 0.5f;
        transform.position = pos;
    }
}
