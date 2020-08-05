using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnManager : MonoBehaviour
{
    private List<Mover> movers = new List<Mover>();
    private int moverCount = 18;
    public GameObject moverPref;

    // Start is called before the first frame update
    void Start()
    {
        for (int i = 0; i < moverCount; i++)
        {
            GameObject instancedMoverPref = Instantiate(moverPref, new Vector3(i, 1.0f, 0), moverPref.gameObject.transform.rotation);
            Mover mover = instancedMoverPref.GetComponent<Mover>();
            mover.offset = i * 0.4f;
            movers.Add(mover);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
