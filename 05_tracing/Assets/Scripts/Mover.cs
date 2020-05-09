using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Mover : MonoBehaviour
{
    private Vector3 p1;
    public GameObject target;
    
    // Start is called before the first frame update
    void Start()
    {
        p1 = new Vector3(0f, 0f, 0f);
    }

    // Update is called once per frame
    void Update()
    {
        var pos = transform.position;
        p1 += (target.transform.position - pos) * 4f * Time.deltaTime;
        p1 -= p1 * 3f * Time.deltaTime;
        pos += p1 * Time.deltaTime;
        transform.position = pos;
        transform.rotation = Quaternion.LookRotation(p1, Vector3.forward);
    }
}